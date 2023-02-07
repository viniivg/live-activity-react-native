import React from 'react';
import {
  SafeAreaView,
  StyleSheet,
  Text,
  TouchableOpacity,
  NativeModules,
} from 'react-native';

function App(): JSX.Element {
  const {LiveActivityModule} = NativeModules;

  return (
    <SafeAreaView style={styles.container}>
      <TouchableOpacity
        style={styles.button}
        onPress={() =>
          LiveActivityModule.startNotification(
            'Burgão do Zé',
            '#02564',
            'Estamos preparando seu pedido.',
            'Em até 30 minutos seu pedido sai para entrega',
            2,
            'Já pingou aqui!',
            'cooking',
          )
        }>
        <Text style={styles.text}>Iniciar Live Activity</Text>
      </TouchableOpacity>

      <TouchableOpacity
        style={styles.button}
        onPress={() => {
          setTimeout(() => {
            LiveActivityModule.updateNotification();
          }, 3000);
        }}>
        <Text style={styles.text}>Atualizar Live Activity</Text>
      </TouchableOpacity>

      <TouchableOpacity
        style={styles.button}
        onPress={() => LiveActivityModule.cancelNotification()}>
        <Text style={styles.text}>Encerrar Live Activity</Text>
      </TouchableOpacity>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  button: {
    padding: 16,
    marginTop: 12,
    justifyContent: 'center',
    alignItems: 'center',
  },
  text: {
    fontSize: 16,
    fontWeight: 'bold',
  },
});

export default App;
